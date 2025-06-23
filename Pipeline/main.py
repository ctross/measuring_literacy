# Need: https://github.com/Rikorose/DeepFilterNet/tree/main
# and: https://ffmpeg.org//download.html#build-windows

# Load libraries
import os
import soundfile as sf
import scipy.signal as signal
import sys
os.chdir("C:\\Users\\cody_ross\\Desktop\\Workflow\\Pipeline")

from pydub import AudioSegment
from torchaudio import AudioMetaData
from df.enhance import enhance, init_df, load_audio, save_audio

mysp=__import__("my-voice-analysis")

def mp3_to_wav(mp3_file, wav_file):
 audio = AudioSegment.from_mp3(mp3_file)
 audio.export(wav_file, format="wav")

def audio_analysis(input_file):
 name = os.path.basename(input_file)
 name, ext = name.split('.')
 if ext == 'mp3':
   print(input_file)
   print(input_file.replace('.mp3','.wav'))
   mp3_to_wav(input_file, input_file.replace('.mp3','.wav'))
   path_file = input_file.replace('.mp3','.wav')
 else:
   path_file = input_file
 model, df_state, _ = init_df()  
 audio, _ = load_audio(path_file, sr = df_state.sr())
 enhanced_audio = enhance(model, df_state, audio)
 path_file_2 = path_file.replace(name, name + "_clean")
 path_file_2 = path_file_2.replace("trimmed", "denoised")
 save_audio(path_file_2, enhanced_audio, df_state.sr())
 original_audio, original_samplerate = sf.read(path_file_2)
 resampled_audio = signal.resample(original_audio, int(len(original_audio)*(44000/original_samplerate)))
 resampled_audio_16bit = (resampled_audio*32767).astype('int16')
 path_file_3 = path_file_2.replace("clean", "clean_44k_16bit")
 path_file_3 = path_file_3.replace("denoised", "resampled")
 sf.write(path_file_3, resampled_audio_16bit, 44000)  
 absolute_path = os.path.abspath(input_file)
 absolute_path = os.path.dirname(absolute_path)
 absolute_path = absolute_path.replace("trimmed", "resampled/")
 sys.stdout = open("data/ratings/" + name + ".txt", 'w')
 r =  mysp.mysptotal(name + '_clean_44k_16bit', absolute_path)
 sys.stdout.close()

if __name__== "__main__":
  audio_analysis(sys.argv[1])
